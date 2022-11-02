local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

local action_setup, actions = pcall(require, "telescope.actions")
if not acttions_setup then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        -- Below shortcuts arent working on MacOS
        -- Check that they will be available on Linux
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_slected_to_qflist + actions.open_qflist,
      }
    }
  }
})

telescope.load_extension("fzf")
