local M = {}

---@param path string?
---@return string|nil git_root
function M.git_dir(path)
  path = path or vim.fn.expand '%:p:h'
  local git_dir = vim.fn.system(string.format('git -C %s rev-parse --show-toplevel', path))
  if vim.fn.match(git_dir, '^fatal:') == -1 then
    return vim.trim(git_dir)
  end
end

---@param path string?
---@return nil
function M.find_all_files(path)
  require('telescope.builtin').find_files {
    cwd = path or vim.fn.getcwd(),
    find_command = {
      'rg',
      '--files',
      '--hidden',
      '-g',
      [[!.git]],
    },
  }
end

return M
