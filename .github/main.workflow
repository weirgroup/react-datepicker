workflow "New workflow" {
  on = "push"
  resolves = ["weirgroup/devops-actions/weir-cmd@master-1"]
}

action "GitHub Action for npm" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "install"
}

action "GitHub Action for npm-1" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["GitHub Action for npm"]
  args = "run build:umd:prod"
}

action "weirgroup/devops-actions/weir-cmd@master" {
  uses = "weirgroup/devops-actions/weir-cmd@master"
  needs = ["GitHub Action for npm-1"]
  args = "git clone --depth 1 --single-branch --branch dist https://$OAUTH_TOKEN:x-oauth-basic@github.com/weirgroup/react-datepicker.git"
  secrets = ["OAUTH_TOKEN"]
}

action "weirgroup/devops-actions/weir-cmd@master-1" {
  uses = "weirgroup/devops-actions/weir-cmd@master"
  needs = ["weirgroup/devops-actions/weir-cmd@master"]
  args = "rm -rf react-datepicker/* react-datepicker/.github react-datepicker/.travis.yml react-datepicker/.editorconfig react-datepicker/.gitignore && cp -R dist package.json README.md react-datepicker"
}
