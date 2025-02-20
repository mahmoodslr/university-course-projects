#include <iostream>
using namespace std;

struct node {
    char info;
    node* next;
};

class DynamicArrayList {
    node* first;
public:
    DynamicArrayList() { first = NULL; }
    void AddtoHead(char e);
    void AddtoTail(char e);
    void AddtoLocation(char e, int index);
    char RemovefromHead();
    char RemovefromTail();
    char RemovefromLocation(int index);
    void RemoveElement(char e);
    void Print();
};

void DynamicArrayList::Print() {
    node* temp = first;
    while (temp != NULL) {
        cout << temp->info << " ";
        temp = temp->next;
    }
    cout << endl;
}

void DynamicArrayList::AddtoHead(char e) {
    node* n = new node();
    n->info = e;
    n->next = first;
    first = n;
}

void DynamicArrayList::AddtoTail(char e) {
    node* n = new node();
    n->info = e;
    n->next = NULL;
    if (first == NULL) {
        first = n;
        return;
    }
    node* temp = first;
    while (temp->next != NULL)
        temp = temp->next;
    temp->next = n;
}

void DynamicArrayList::AddtoLocation(char e, int index) {
    if (index < 1) {
        cout << "Invalid index!" << endl;
        return;
    }
    node* newNode = new node();
    newNode->info = e;
    if (index == 1) {
        newNode->next = first;
        first = newNode;
        return;
    }
    node* temp = first;
    for (int i = 1; temp != NULL && i < index - 1; i++)
        temp = temp->next;
    if (temp == NULL) {
        cout << "Index out of bounds!" << endl;
        return;
    }
    newNode->next = temp->next;
    temp->next = newNode;
}

char DynamicArrayList::RemovefromHead() {
    if (first == NULL) return '\0';
    node* temp = first;
    first = first->next;
    char data = temp->info;
    delete temp;
    return data;
}

char DynamicArrayList::RemovefromTail() {
    if (first == NULL) return '\0';
    if (first->next == NULL) {
        char data = first->info;
        delete first;
        first = NULL;
        return data;
    }
    node* temp = first;
    while (temp->next->next != NULL)
        temp = temp->next;
    char data = temp->next->info;
    delete temp->next;
    temp->next = NULL;
    return data;
}

void DynamicArrayList::RemoveElement(char e) {
    while (first != NULL && first->info == e) {
        node* temp = first;
        first = first->next;
        delete temp;
    }
    node* temp = first;
    while (temp != NULL && temp->next != NULL) {
        if (temp->next->info == e) {
            node* delNode = temp->next;
            temp->next = temp->next->next;
            delete delNode;
        } else {
            temp = temp->next;
        }
    }
}

int main() {
    DynamicArrayList dList;
    dList.AddtoHead('A');
    dList.AddtoTail('B');
    dList.AddtoTail('C');
    dList.Print();
    dList.RemovefromHead();
    dList.Print();
    return 0;
}
