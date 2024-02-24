# 💤 time-to-sleep.nvim

A nvim plugin that adds the function to write journals in a fully customisable floating window.
![Journal floating window](https://private-user-images.githubusercontent.com/93316844/307545348-33a720ef-a0d8-448e-8d60-72246c97235c.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MDg4MDMyODcsIm5iZiI6MTcwODgwMjk4NywicGF0aCI6Ii85MzMxNjg0NC8zMDc1NDUzNDgtMzNhNzIwZWYtYTBkOC00NDhlLThkNjAtNzIyNDZjOTcyMzVjLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDAyMjQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwMjI0VDE5Mjk0N1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTRlNzRkMTRhMjhlNDhlYzdlMWYxNjkyNjVhN2Q1ODIwZDliZDE2NGY1MDEzMWJjNzcwYWJkMTIzZmNlYTIwYzAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.yD-_S4PkDoGxMYv7Ik-qRgObbPTYEOrQ0_PMwdWFmBY)

## ✨ Features

- 📔 Floating journal window that gives you a new journal everyday (.md files).
- 😊 Many tabs too help with writing your journals : emojis, titles, history of journals...
- 💫 A little chear up pop up (can be disable if you don't want to be happy).
- ❌ When it is past 23 nvim will remind you to go to sleep.

## ⚡️ Requirements

- Nvim >= 0.8.0
- [Nerd Font](https://www.nerdfonts.com/) for emojis.
- [Lualine](https://github.com/nvim-lualine/lualine.nvim) for a better experience but it is not required

## 📦 Installation
Install with your favorite package manager

 ⚠️ Don't forget to add :

```lua

require("time-to-sleep").setup({
    -- You config or nothing if you want the default
})

```

## 🔧 Configuration

This is the default Configuration with the default mappings.

```lua
{
    default_pos = "x"
    tts_toggle = true
    lualine_tts_toggle = false -- If you have lualine it is better
    emojis = { -- Every default emojis for the emoji tab
        "😊", "😀", "😅", "😂", "🤣", "😉", "😍", "😘", "😜", "😎",
        "😇", "🥰", "🤩", "😋", "😆", "😁", "😄", "😃", "😚", "😙",
        "👍", "👌", "👏", "🙌", "🤝", "🎉", "🎊", "🌟", "🌈", "🎈",
        "🎁", "🎀", "🥳", "🍾", "🎶", "🎵", "🍀", "🌺", "🌸",
        "✏️", "📝", "📖", "📚", "📔", "📓", "📒", "📕", "📗", "📘",
        "📙", "📚", "📖", "📜", "📄", "📃", "📑", "📊", "📈", "📉",
    }

    journal_tabs = { -- Add here your tabs up to 7 (3 existing tabs currently but planning on adding 2 more)
        "emojis",    -- The order matters. Emojis will be the first tab with a spacing of 35 and the toggle mapping "1"
        "titles",    -- Titles comes second so it will be with a spacing of 30 and the toggle mapping "2"
        "history",   -- Guess
    }
    journal_tabs_spacing = { -- Position of tabs relative to the floating window
        35,
        30,
        25,
        20,
        15,
        10,
        5
    }
    toggle_tabs_mappings = { -- Tab toggle mappings
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7"
    }
    mappings = {
        journal = { -- Opening and exiting journal floating window
            open = "<leader>j",
            save_and_quit = "<Esc>",
        },
        tts = { -- Stop the plugin from chearing you up
            stop = "<leader>t"
        }
    }
}

```
## ✏️ Usage

Every tab works on the action of deleting what you need.

For example in Emoji tab:
- Open it with "1" (default)
- Look for what emoji you want to use
- Delete it (with "dw" or "dd")
- Close tab with "<Esc>" or "1"
- Paste it ! 🏆

⚠️  For the history tab ⚠️ :
- Open it
- Look for what journal you want to open based on date
- Delete the date (with "dd")
- Close tab with the toggle mapping to confirm your choice
- The journal corresponding to the date you deleted will open. (It saves the journal you were in)

## ⚠️ End word
This plugin is still in development.
