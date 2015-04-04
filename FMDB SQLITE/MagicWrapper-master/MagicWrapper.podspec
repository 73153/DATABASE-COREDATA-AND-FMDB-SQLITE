Pod::Spec.new do |s|
  s.name             = "MagicWrapper"
  s.version          = "0.1.1"
  s.summary          = "Magic Wrapper is an Objective-C client/wrapper for M:tgDb."
  s.description      = <<-DESC
                       Magic Wrapper is an Objective-C client/wrapper for [M:tgDb], the Magic the Gathering open database project. It consists of an API wrapper, responsible for the network calls (``MTGAPIWrapper``), requests classes (subclasses of the ``MTGRequest`` class), and classes for cards and card sets (``MTGCard`` and ``MTGCardSet``).
                       DESC
  s.homepage         = "https://github.com/otaviocc/MagicWrapper"
  s.license          = 'MIT'
  s.author           = { "Otavio Cordeiro" => "contact@otaviocc.com" }
  s.source           = { :git => "https://github.com/otaviocc/MagicWrapper.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/otaviocc'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  
  s.source_files = 'Magic/MTG*.[h,m]', 'Magic/MagicWrapper.h', 'Magic/*+MagicWrapper.[h,m]'

  s.dependency 'AFNetworking', '~> 2.4'
end
