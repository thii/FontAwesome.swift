# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

swiftlint.config_file = ".swiftlint.yml"
swiftlint.lint_files

# Make a note about new contributors
unless github.api.collaborator?("thii/FontAwesome.swift", github.pr_author)
  message "@#{github.pr_author} is not a contributor yet, would you like to be a FontAwesome.swift maintainer?"
end
