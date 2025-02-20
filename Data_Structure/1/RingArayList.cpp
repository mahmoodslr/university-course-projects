#include <iostream>
using namespace std;

struct node {
    char info;
    node* next;
};

// ********** RingArrayList (لیست حلقوی) **********
class RingArrayList {
    node* first;
public:
    RingArrayList() { first = NULL; }
    void AddtoHead(char e);
    void AddtoTail(char e);
    int Size();
    void RemovefromLocation(int loc);
    void RemoveElement(char e);
    void Print();
};

void RingArrayList::Print() {
    if (first == NULL) return;
    node* temp = first;
    do {
        cout << temp->info << " ";
        temp = temp->next;
    } while (temp != first);
    cout << endl;
}

void RingArrayList::AddtoHead(char e) {
    node* temp = new node();
    temp->info = e;
    if (first == NULL) {
        first = temp;
        first->next = first;
    } else {
        temp->next = first->next;
        first->next = temp;
    }
}

void RingArrayList::AddtoTail(char e) {
    node* temp = new node();
    temp->info = e;
    if (first == NULL) {
        first = temp;
        first->next = first;
    } else {
        node* a = first;
        while (a->next != first)
            a = a->next;
        temp->next = first;
        a->next = temp;
    }
}

int RingArrayList::Size() {
    if (first == NULL) return 0;
    int cnt = 0;
    node* cur = first;
    do {
        cur = cur->next;
        cnt++;
    } while (cur != first);
    return cnt;
}

void RingArrayList::RemovefromLocation(int loc) {
    if (first == NULL) return;
    node *temp = first, *prev = NULL;
    for (int i = 1; i < loc; i++) {
        prev = temp;
        temp = temp->next;
    }
    if (temp == first) {
        prev->next = first->next;
        first = first->next;
    } else {
        prev->next = temp->next;
    }
    delete temp;
}

void RingArrayList::RemoveElement(char e) {
    if (first == NULL) return;
    node *temp = first, *prev = NULL;
    do {
        if (temp->info == e) {
            if (prev == NULL) {
                first = temp->next;
            } else {
                prev->next = temp->next;
            }
            delete temp;
            return;
        }
        prev = temp;
        temp = temp->next;
    } while (temp != first);
}

int main() {
    RingArrayList List;
    char element;
    int location;
    cin >> element;
    List.AddtoHead(element);
    cin >> element;
    List.AddtoHead(element);
    cin >> element;
    List.AddtoTail(element);
    cout << List.Size() << endl;
    cin >> location;
    List.RemovefromLocation(location);
    cout << List.Size() << endl;
    cin >> element;
    List.RemoveElement(element);
    List.Print();
    return 0;
}
