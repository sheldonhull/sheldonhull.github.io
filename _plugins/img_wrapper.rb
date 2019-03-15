# Description: Jekyll plugin to replace Markdown image syntax with {% picture %} tag for crafting responsive images
# place in /_plugins/
# https://gist.github.com/mmistakes/77c68fbb07731a456805a7b473f47841

# Description: Jekyll plugin to replace Markdown image syntax with lazyload HTML markup
# THIS WORKS
Jekyll::Hooks.register :posts, :pre_render do |post, payload|
    docExt = post.extname.tr('.', '')
    # only process if we deal with a markdown file
    if payload['site']['markdown_ext'].include? docExt
      newContent = post.content.gsub(/(?:!\[(.*?)\]\((.*?)\))/, '<a href="\2" data-fancybox="gallery" data-caption="\1"><img src="\2" alt="\1" class="fade in"/></a>')
      post.content = newContent
    end
  end
