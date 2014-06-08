module SpritesHelper
  def sprite(a_sprite )
    capture_haml do
      haml_tag :div, :class => "sprite", :id => "f#{a_sprite.id}"
    end

  end

end
