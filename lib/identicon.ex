defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
  end

  def build_pixel_map(%Identicon.Image{grid:grid} = image) do
      
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) -> 
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
    
    %Identicon.Image{ image | grid: grid}
  end

  @doc """
    Takes a list of three, i.e. [1,2,3]
    Returns a list of 5, i.e. [1,2,3,2,1]
  """
  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  @doc """
  
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
