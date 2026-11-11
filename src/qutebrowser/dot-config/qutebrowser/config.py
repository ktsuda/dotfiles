import os
from urllib.request import urlopen

# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

if os.path.exists(config.configdir / "theme.py"):
    import theme
    theme.setup(c, 'mocha', True)

# utilities
config.set("auto_save.session", True)
c.auto_save.session = True
c.content.pdfjs = True
c.url.default_page = "https://start.duckduckgo.com/"
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "d": "https://dictionary.cambridge.org/dictionary/english/{}",
    "g": "https://github.com/search?q={}",
    "s": "https://scholar.google.com/scholar?hl=ja&q={}",
    "y": "https://www.youtube.com/results?search_query={}",
}

# appearance
c.tabs.position = "bottom"
c.tabs.width = 160
c.tabs.padding = {"bottom": 4, "left": 4, "right": 4, "top": 4}

# Pages where qutebrowser keys are off (passthrough mode). Leave with <Shift+Escape>.
passthrough_urls = [
    # "https://mail.google.com/*",
    "https://mail.google.com/mail/*",
]
for url in passthrough_urls:
    config.set("input.mode_override", "passthrough", url)

# key bindings
config.bind("sq", "quickmark-save")
config.bind("<Ctrl+r>", "config-source")

config.bind("<Ctrl+f>", "fake-key <right>", mode="insert")
config.bind("<Ctrl+b>", "fake-key <left>", mode="insert")
config.bind("<Ctrl+n>", "fake-key <down>", mode="insert")
config.bind("<Ctrl+p>", "fake-key <up>", mode="insert")
config.bind("<Ctrl+a>", "fake-key <home>", mode="insert")
config.bind("<Ctrl+e>", "fake-key <end>", mode="insert")
config.bind("<Ctrl+d>", "fake-key <delete>", mode="insert")
config.bind("<Ctrl+h>", "fake-key <backspace>", mode="insert")

config.bind("<Ctrl+n>", "completion-item-focus --history next", mode="command")
config.bind("<Ctrl+p>", "completion-item-focus --history prev", mode="command")

config.bind("[", ":tab-prev")
config.bind("]", ":tab-next")
config.bind("<Ctrl+Shift+Tab>", ":tab-prev")
config.bind("<Ctrl+Tab>", ":tab-next")
config.bind("{", ":tab-move -")
config.bind("}", ":tab-move +")
config.bind("<Meta+[>", ":back")
config.bind("<Meta+]>", ":forward")

# 1Password: types into the focused field, so also bound in insert mode
for mode in ("normal", "insert"):
    config.bind("<Ctrl+Shift+x>", "spawn --userscript ~/.config/qutebrowser/qute-1pass", mode=mode)
