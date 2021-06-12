defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "return a player" do
      player = ExMon.create_player("Roberto", :soco, :chute, :cura)

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Roberto"
      }

      assert player == expected_response
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = ExMon.create_player("Roberto", :soco, :chute, :cura)

      message =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert message =~ "The game is started!"
      assert message =~ "status: :started"
      assert message =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = ExMon.create_player("Roberto", :soco, :chute, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      message =
        capture_io(fn ->
          assert ExMon.make_move(:soco) == :ok
        end)

      assert message =~ "The Player attacked the computer dealing"
      assert message =~ "It's computer turn"
      assert message =~ "It's player turn"
      assert message =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      message =
        capture_io(fn ->
          assert ExMon.make_move(:wrong) == :ok
        end)

      assert message =~ "Invalid move: wrong!"
    end

    test "when the move left, returns an game over message" do
      message =
        capture_io(fn ->
          Enum.each(1..15, fn _ ->
            ExMon.make_move(:chute)
          end)
        end)

      assert message =~ "The game is over"
      assert message =~ "status: :game_over"
    end

    test "when the move is heal, returns an healing message" do
      message =
        capture_io(fn ->
          ExMon.make_move(:cura)
        end)

      assert message =~ "The player healled itself to"
      assert message =~ "status: :continue"
    end
  end
end
