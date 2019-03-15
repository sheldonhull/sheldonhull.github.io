# Description: Jekyll plugin to replace Markdown image syntax with {% picture %} tag for crafting responsive images
# place in /_plugins/
# https://gist.github.com/mmistakes/77c68fbb07731a456805a7b473f47841

# Jekyll::Hooks.register :posts, :pre_render do |post, payload|
#    docExt = post.extname.tr('.', '')
#    # only process if we deal with a markdown file
#    if payload['site']['markdown_ext'].include? docExt
#      newContent = post.content.gsub(/\!\[(.+)\]\((.+)\)/, '{% picture default \2 alt="\1" %}')
#      post.content = newContent
#    end
#  end

# Description: Jekyll plugin to replace Markdown image syntax with lazyload HTML markup
# THIS WORKS
Jekyll::Hooks.register :posts, :pre_render do |post, payload|
   docExt = post.extname.tr('.', '')
   # only process if we deal with a markdown file
   if payload['site']['markdown_ext'].include? docExt
     newContent = post.content.gsub(/(?:!\[(.*?)\]\((.*?)\))/, '<noscript><img src="\2"></noscript><img src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" data-src="\2" alt="\1" class="lazyload fade-in">')
     post.content = newContent
   end
 end
#
# Jekyll::Hooks.register :posts, :pre_render do |post, payload|
    # docExt = post.extname.tr('.', '')
 #   only process if we deal with a markdown file
    # if payload['site']['markdown_ext'].include? docExt
      # newContent = post.content.gsub(/(?:!\[(.*?)\]\((.*?)\))/, '<a href="\2"><img src="\2" alt="\1"></a>')
      # post.content = newContent
    # end
  # end
#
#Description: Jekyll plugin to replace Markdown image syntax with {% picture %} tag for crafting responsive images
# place in /_plugins/

# Jekyll::Hooks.register :posts, :pre_render do |post, payload|
#     docExt = post.extname.tr('.', '')
#     # only process if we deal with a markdown file
#     if payload['site']['markdown_ext'].include? docExt
#       newContent = post.content.gsub(/\!\[(.+)\]\((.+)\)/, '<a href="\2"><img src="\2" alt="\1"/></a>')
#       post.content = newContent
#     end
#   end