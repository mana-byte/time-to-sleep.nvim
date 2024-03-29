# 💤 time-to-sleep.nvim

A nvim plugin that adds the function to write journals in a fully customisable floating window.
![Journal floating window](https://github.com/mana-byte/time-to-sleep.nvim/assets/93316844/33a720ef-a0d8-448e-8d60-72246c97235c)
![image](https://github.com/mana-byte/time-to-sleep.nvim/assets/93316844/1c09b6e5-110f-4eb1-80c1-67021825225b)
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
    tts_toggle = true
    lualine_tts_toggle = false -- If you have lualine it is better
    default_pos = "x" -- If you have lualine
    emojis = { -- Every default emojis for the emoji tab
        "😊", "😀", "😅", "😂", "🤣", "😉", "😍", "😘", "😜", "😎",
        "😇", "🥰", "🤩", "😋", "😆", "😁", "😄", "😃", "😚", "😙",
        "👍", "👌", "👏", "🙌", "🤝", "🎉", "🎊", "🌟", "🌈", "🎈",
        "🎁", "🎀", "🥳", "🍾", "🎶", "🎵", "🍀", "🌺", "🌸",
        "✏️", "📝", "📖", "📚", "📔", "📓", "📒", "📕", "📗", "📘",
        "📙", "📚", "📖", "📜", "📄", "📃", "📑", "📊", "📈", "📉",
    }
    code_blocks = { -- Every default code blocks for the code block tab
        "```lua  ```",
        "```java    ```",
        "```py    ```",
        "```sql    ```",
        "```cpp    ```",
    }

    journal_tabs = { -- Add here your tabs up to 7 (3 existing tabs currently but planning on adding 2 more)
        "emojis",    -- The order matters. Emojis will be the first tab with a spacing of 35 and the toggle mapping "1"
        "titles",    -- Titles comes second so it will be with a spacing of 30 and the toggle mapping "2"
        "history",   -- Guess
        "code_blocks",
    }
    custom_journal_tabs = {
        -- custom tabs/ created tabs go in here
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
            open = "<leader>j", -- In normal mode
            open_with_code = "<leader>j", -- In visual mode the code you selected will be pasted in the journal automatically as a code block
            save_and_quit = "<Esc>",
        },
        tts = { -- Stop the plugin from chearing you up
            stop = "<leader>t"
        }
    }
}

```
## ✏️ Usage

### - ✏️ Journal
- Open the journal with the mapping you set in the Configuration

### - 🚀 A very pratical and handy feature:

- You can enter visual mode, select the code you want to paste in the journal and then open the journal with the mapping you set in the Configuration. The code will be pasted in the journal as a code block.

### - 📂 Tabs
Every tab works on the action of deleting what you need.

For example in Emoji tab:
- Open it with "1" (default)
- Look for what emoji you want to use
- Delete it (with "dw" or "dd")
- Close tab with "Esc" (default) or "1"
- Paste it ! 🏆

⚠️  For the history tab ⚠️ :
- Open it
- Look for what journal you want to open based on date
- Delete the date (with "dd")
- Close tab with the toggle mapping to confirm your choice
- The journal corresponding to the date you deleted will open. (It saves the journal you were in)

## 💬 Adding new Tabs / Creating custom tabs !
- To create a new tab just write this before your require("time-to-sleep").setup().
```lua
require("time-to-sleep").create_tab(tab_name, tab_id, tab_filetype, tab, content)

-- tab_id is what you will use in your config to call the tab: String
-- if tab_file_type is nil then tab_filetype = 'markdown' : String
-- tab is the emoji will represent the tab is the journal menu : String
-- content is what the tab will display once you open it up : Table of String

```
- In your config don't forget to add the tab_id in the custom_journal_tabs so that the tab will load.

The custom tabs will be placed at the end of the tab list.

### Example config with a custom tab:
```lua
    {
        "mana-byte/time-to-sleep.nvim",
        config = function()
            local time_to_sleep = require("time-to-sleep")
            time_to_sleep.create_tab("alphabet", 'alphabet', 'markdown', '🍃', {
                "a",
                "b",
                "c",
            })
            time_to_sleep.setup({
                lualine_tts_toggle = true,
                custom_journal_tabs = {
                    'alphabet'
                }
            })
        end
    }
```
## 🚧 This plugin is still in development
