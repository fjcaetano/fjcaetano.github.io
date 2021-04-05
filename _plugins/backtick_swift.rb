Jekyll::Hooks.register :posts, :pre_render do |post|
  post.content.gsub!(/^`{3}\s*swift\n(.+?)\n`{3}/m) do
    "{% splash %}\n#{$1}\n{% endsplash %}"
  end
end