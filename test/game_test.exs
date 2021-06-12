defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Roberto", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Roberto", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Roberto"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "return the game state updated" do
      player = Player.build("Roberto", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Roberto"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Roberto"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | status: :continue, turn: :computer}

      assert Game.info() == expected_response
    end

    test "return then game over" do
      player = Player.build("Roberto", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Roberto"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response

      new_state = %{
        computer: %Player{
          life: 0,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Roberto"
        },
        status: :game_over,
        turn: :player
      }

      Game.update(new_state)

      assert Game.info() == new_state
    end
  end

  describe "player/0" do
    test "return the player updated" do
      player = Player.build("Roberto", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      assert Game.player() == player
    end
  end

  describe "turn/0" do
    test "return the turn" do
      player = Player.build("Roberto", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      assert Game.turn() == :player

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Robotinik"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Roberto"
        },
        status: :started,
        turn: :computer
      }

      Game.update(new_state)

      assert Game.turn() == :player
    end
  end

  describe "fetch_player/1" do
    test "return the player" do
      player = Player.build("Roberto", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      assert Game.fetch_player(:player) == player
    end
  end
end
