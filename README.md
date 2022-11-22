***anarsoul's nvim config***

Heavily inspired by  https://github.com/LunarVim/nvim-basic-ide

To install TreeSitter plugins run `:TSInstall all`

If you use nix and see following error:

```
Error executing lua Failed to load parser: uv_dlopen: libstdc++.so.6
```

Do: `:TSUninstall all` from nvim, then `nix-shell -p gcc` from shell, then `:TSInstall all`
