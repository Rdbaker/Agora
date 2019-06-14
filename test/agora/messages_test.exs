defmodule Agora.MessagesTest do
  use Agora.DataCase

  alias Agora.Messages

  describe "messages" do
    alias Agora.Messages.Message

    @valid_attrs %{attributes: %{}, author_type: "some author_type", body: "some body", event: %{}, message_type: "some message_type", raw_body: "some raw_body", user_context: %{}}
    @update_attrs %{attributes: %{}, author_type: "some updated author_type", body: "some updated body", event: %{}, message_type: "some updated message_type", raw_body: "some updated raw_body", user_context: %{}}
    @invalid_attrs %{attributes: nil, author_type: nil, body: nil, event: nil, message_type: nil, raw_body: nil, user_context: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Messages.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messages.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Messages.create_message(@valid_attrs)
      assert message.attributes == %{}
      assert message.author_type == "some author_type"
      assert message.body == "some body"
      assert message.event == %{}
      assert message.message_type == "some message_type"
      assert message.raw_body == "some raw_body"
      assert message.user_context == %{}
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = Messages.update_message(message, @update_attrs)
      assert message.attributes == %{}
      assert message.author_type == "some updated author_type"
      assert message.body == "some updated body"
      assert message.event == %{}
      assert message.message_type == "some updated message_type"
      assert message.raw_body == "some updated raw_body"
      assert message.user_context == %{}
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_message(message, @invalid_attrs)
      assert message == Messages.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messages.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messages.change_message(message)
    end
  end
end
