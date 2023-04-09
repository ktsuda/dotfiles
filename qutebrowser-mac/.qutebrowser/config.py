# configuration file for qutebrowser
config.load_autoconfig(False)

# utilities
config.set("auto_save.session", True)
c.auto_save.session = True
c.content.pdfjs = True
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "d": "https://dictionary.cambridge.org/dictionary/english/{}",
    "g": "https://github.com/search?q={}",
    "s": "https://stackoverflow.com/search?q={}",
    "y": "https://www.youtube.com/results?search_query={}",
}

# appearance
c.tabs.position = "right"
c.tabs.width = 160
c.tabs.padding = {"bottom": 4, "left": 4, "right": 4, "top": 4}
c.window.hide_decoration = False

config.source("gruvbox.py")

# key bindings
config.bind("sq", "quickmark-save")

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
