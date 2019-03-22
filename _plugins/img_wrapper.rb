# Description: Jekyll plugin to replace Markdown image syntax with {% picture %} tag for crafting responsive images
# place in /_plugins/
# https://gist.github.com/mmistakes/77c68fbb07731a456805a7b473f47841

# Description: Jekyll plugin to replace Markdown image syntax with lazyload HTML markup
# THIS WORKS
# Jekyll::Hooks.register :posts, :pre_render do |post, payload|
#     docExt = post.extname.tr('.', '')
#     # only process if we deal with a markdown file
#     if payload['site']['markdown_ext'].include? docExt
#       newContent = post.content.gsub(/(?:!\[(.*?)\]\((.*?)\))/, '<a href="\2"><img src="\2" alt="\1" class="fade in"/></a>')
#       post.content = newContent
#     end
#   end

Jekyll::Hooks.register :posts, :pre_render do |post, payload|
  docExt = post.extname.tr('.', '')
  # only process if we deal with a markdown file
  if payload['site']['markdown_ext'].include? docExt
    ##newContent = post.content.gsub(/(?:!\[(.*?)\]\((.*?)\))/, '<noscript><img src="\2"></noscript><img src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" data-src="\2" alt="\1" class="lazyload fade-in">')

    #      Kramdown is finicky about when it will or won't listen to the nomarkdown option, depending on the line breaks before, after, and within the block. The most general solution I've found is to remove all line breaks from j-p-t's output, giving the whole shebang on one line. It makes for ugly markup, but it's pretty much only ever seen by the browser anyway. If you know a better way to accomplish this, I'm all ears!
    regex = /(?:!\[)(.*?)(?:\]\(.*\/)(.*?)(?:\))/

    newContent = post.content.gsub(regex, '{% picture lazy \2 --alt \1  %}') # single quotes work, double quotes give bad character

    #Jekyll.logger.info(("match[2]|name"  + post.content.match(regex)[2]))
    #Jekyll.logger.info(("match[1]|alt:" + post.content.match(regex)[1]))
    Jekyll.logger.info("newcontent: " + newContent)

    #newContent = post.content.gsub(/(\!\[)(.*?)(\]\(\/assets\/img\/)(.*?)(\))/, "{% picture lazy \2 --alt \4  %}")
    post.content = newContent
  end
end