class Player
  def initialize(name, piece)
    @name = name
    @piece = piece
  end

  def get_name
    @name
  end

  def get_piece
    @piece
  end

  def set_name(name)
    @name = name
  end

  def set_piece(piece)
    @piece = piece
  end
end
