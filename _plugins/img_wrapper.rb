# Description: Jekyll plugin to replace Markdown image syntax with {% picture %} tag for crafting responsive images
# place in /_plugins/
# https://gist.github.com/mmistakes/77c68fbb07731a456805a7b473f47841
# Jekyll Picture https://github.com/robwierzbowski/jekyll-picture-tag#markup-presets
# Description: Jekyll plugin to replace Markdown image syntax with lazyload HTML markup
# THIS WORKS
Jekyll::Hooks.register :posts, :pre_render do |post, payload|
    docExt = post.extname.tr('.', '')
    # only process if we deal with a markdown file
    if payload['site']['markdown_ext'].include? docExt
      # newContent = post.content.gsub(/(?:!\[(.*?)\]\((.*?)\))/, '<a href="\2"><img src="\2" alt="\1" class="fade in"/></a>')
      # newContent = post.content.gsub(/\!\[(.+)\]\((.+)\)/, '{% picture lazy \2 --alt "\1" %}')
      newContent = post.content.gsub(/\!\[(.*?)\]\(\/assets\/img\/(.+)\)/, '{% picture lazy \2 --alt \1 %}')
      post.content = newContent
      Jekyll.logger.info newContent
    end
  end
