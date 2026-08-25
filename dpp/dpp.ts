import {
  BaseConfig,
  type ConfigReturn,
} from "jsr:@shougo/dpp-vim@~4.1.0/config";
import type {
  ContextBuilder,
  Dpp,
  Plugin,
} from "jsr:@shougo/dpp-vim@~4.1.0/types";
import type { Denops } from "jsr:@denops/std@~7.5.0";
import * as fn from "jsr:@denops/std@~7.5.0/function";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<ConfigReturn> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    const configDir = await fn.expand(args.denops, "~/.vim/dpp") as string;
    const tomls: { path: string; lazy: boolean }[] = [
      { path: `${configDir}/dpp.toml`, lazy: false },
      { path: `${configDir}/dpp_lazy.toml`, lazy: true },
      { path: `${configDir}/local_dpp.toml`, lazy: false },
      { path: `${configDir}/local_dpp_lazy.toml`, lazy: true },
    ];

    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, string> = {};
    const hooksFiles: string[] = [];
    const checkFiles: string[] = [];

    for (const toml of tomls) {
      if (await fn.filereadable(args.denops, toml.path)) {
        checkFiles.push(toml.path);
        const tomlPlugins = await args.dpp.extAction(
          args.denops,
          context,
          options,
          "toml",
          "load",
          {
            path: toml.path,
            options: {
              lazy: toml.lazy,
            },
          },
        ) as {
          plugins?: Plugin[];
          ftplugins?: Record<string, string>;
          hooksFiles?: string[];
        } | undefined;

        if (tomlPlugins) {
          if (tomlPlugins.plugins) {
            for (const plugin of tomlPlugins.plugins) {
              recordPlugins[plugin.name] = plugin;
            }
          }
          if (tomlPlugins.ftplugins) {
            for (const [ft, code] of Object.entries(tomlPlugins.ftplugins)) {
              ftplugins[ft] = (ftplugins[ft] || "") + `\n${code}`;
            }
          }
          if (tomlPlugins.hooksFiles) {
            hooksFiles.push(...tomlPlugins.hooksFiles);
          }
        }
      }
    }

    const lazyResult = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: Object.values(recordPlugins),
      },
    ) as {
      plugins: Plugin[];
      stateLines: string[];
    } | undefined;

    return {
      checkFiles,
      ftplugins,
      hooksFiles,
      plugins: lazyResult?.plugins ?? Object.values(recordPlugins),
      stateLines: lazyResult?.stateLines ?? [],
    };
  }
}
