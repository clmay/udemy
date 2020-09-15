defmodule Identicon do
  def create(input) do
    input
    |> hash()
    |> color()
    |> filled()
    |> coordinates()
    |> render()
    |> save(input)
  end

  def hash(input) do
    hash =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hash: hash}
  end

  def color(%Identicon.Image{hash: [r, g, b | _rest]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def filled(%Identicon.Image{hash: hash} = image) do
    filled =
      hash
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(fn [first, second, third] = _row ->
        [first, second, third, second, first]
      end)
      |> List.flatten()
      |> Enum.with_index()
      |> Enum.filter(fn {value, _index} ->
        rem(value, 2) == 0
      end)
      |> Enum.map(fn {_value, index} ->
        index
      end)

    %Identicon.Image{image | filled: filled}
  end

  def coordinates(%Identicon.Image{filled: filled} = image, scale \\ 50) do
    coordinates =
      Enum.map(filled, fn index ->
        x = rem(index, 5) * scale
        y = div(index, 5) * scale

        top_left = {x, y}
        bottom_right = {x + scale, y + scale}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image | coordinates: coordinates}
  end

  def render(%Identicon.Image{color: color, coordinates: coordinates}) do
    image = :egd.create(250, 250)
    color = :egd.color(color)

    Enum.each(coordinates, fn {top_left, bottom_right} ->
      :egd.filledRectangle(image, top_left, bottom_right, color)
    end)

    :egd.render(image)
  end

  def save(image, filename) do
    File.write("#{filename}.png", image)
  end
end
