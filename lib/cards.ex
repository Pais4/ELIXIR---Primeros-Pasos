defmodule Cards do

  #Sintax para escribir documentacion del modulo
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """
  
  #Funcion para crear el array de las cartas
  #Documentacion de la funcion
  @doc """
    Returns a list of Strings representing a deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    #List Comprehension, iteración del array
    #Para cada elemento de la lista, haz lo siguiente...
    #Podemos usar varias List Comprehension en una misma linea de code
    #Y luego lo pone en un nuevo array de salida
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

  end

  #Funcion para barajar las cartas, recibe un array de cartas
  def shuffle(deck) do
    #Metodo que se usa para hacer un Random de la posicion del array
    Enum.shuffle(deck)
  end

  #Cuando esperamos que retorne un True o False es viable colocar -> ? 
  #No crea ningun comportamiento en especifico, es solo una convencion
  @doc """
    Determines whether a deck contains a given card

  ## Examples
        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  #Este metodo devuelve una tupla
  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should 
    be in the hand.

  ## Examples
        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  #Guardamos el mazo de cartas en el sistema
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  #Funcion para traer los datos del archivo guardado en el sistema
  def load(filename) do
    #Pattern Matching -> Parecido a la desestructuracion de datos
    #Utilizamos un case pasa saber si retorno un status ok o un error
    case File.read(filename) do
      #:palabra -> Atom, sirve para manejar estados de error o mensajes
      #Se puede pensar en ellos como si fueran un String para los Devs
      {:ok, binary} -> :erlang.binary_to_term(binary)
      #_ -> Se utiliza para dar a conocer que la variable se esta usando asi no se note.
      {:error, _reason} -> "That file does not exists."
    end
  end

  #Crea un mazo de cartas llamando varios metodos que ya hemos creado anteriormente
  #Para lograr esto utilizaremos Pipe operator, para lograr una cadena de funciones
  def create_hand(hand_size) do
    #Pipe Operator -> |>
    #El pipe automaticamente coge lo que crea la funcion y se lo pasa a la siguiente
    #Por lo que no hay necesidad de guardar el resultado en una variable.
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
