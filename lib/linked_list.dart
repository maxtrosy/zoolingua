import 'node.dart';

class LinkedList {
  Node? head;

  void add(String syllable) {
    if (head == null) {
      head = Node(syllable);
    } else {
      Node current = head!;
      while (current.next != null) {
        current = current.next!;
      }
      current.next = Node(syllable);
    }
  }

  void remove(String syllable) {
    if (head == null) return;

    if (head!.syllable == syllable) {
      head = head!.next;
      return;
    }

    Node current = head!;
    while (current.next != null) {
      if (current.next!.syllable == syllable) {
        current.next = current.next!.next;
        return;
      }
      current = current.next!;
    }
  }

  List<String> toList() {
    List<String> syllables = [];
    Node? current = head;
    while (current != null) {
      syllables.add(current.syllable);
      current = current.next;
    }
    return syllables;
  }
}