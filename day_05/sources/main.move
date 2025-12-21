/// DAY 5: Control Flow & Mark Habit as Done
/// 
/// Today you will:
/// 1. Learn if/else statements
/// 2. Learn how to access vector elements
/// 3. Write a function to mark a habit as completed

module challenge::day_05 {
    use std::vector;
    use std::u64;
    use std::bool;

    // Copy from day_04
    public struct Habit has copy, drop {
        name: vector<u8>,
        completed: bool,
    }

    public struct HabitList has drop {
        habits: vector<Habit>,
    }

    public fun new_habit(name: vector<u8>): Habit {
        Habit {
            name,
            completed: false,
        }
    }

    public fun empty_list(): HabitList {
        HabitList {
            habits: vector::empty(),
        }
    }

    public fun add_habit(list: &mut HabitList, habit: Habit) {
        vector::push_back(&mut list.habits, habit);
    }

    // TODO: Write a function 'complete_habit' that:
    // - Takes list: &mut HabitList and index: u64
    // - Checks if index is valid (less than vector length)
    // - If valid, marks that habit's completed field as true
    // Use vector::length() to get the length
    // Use vector::borrow_mut() to get a mutable reference to an element
    // public fun complete_habit(list: &mut HabitList, index: u64) {
    //     // Your code here
    //     // Hint: if (index < length) { ... }
    // }

    public fun complete_habit(list: &mut HabitList, index: u64) {
        let habit_count: u64 = vector::length(&list.habits);
        if (index < habit_count) {
            let hbt: &mut Habit = vector::borrow_mut(&mut list.habits, index);
            hbt.completed = true;
        }
    }

    #[test]
    public fun is_completed(list: &HabitList, index: u64): bool {
        let our_habit = vector::borrow(&list.habits, index);
        let is_completed_bool: bool = our_habit.completed;
        is_completed_bool
    }
}

#[test_only]
module challenge::day_05_tests {
    use std::vector;
    use challenge::day_05::{Self, HabitList, Habit};
    use std::unit_test::assert_eq;

    #[test]
    fun test_habit_completed() {
        let mut list = day_05::empty_list();
        

        let h1 = day_05::new_habit(b"Su ic");
        let h2 = day_05::new_habit(b"Kod yaz");

        day_05::add_habit(&mut list, h1); // içine eleman ekliyoruz o yüzden &mut var
        day_05::add_habit(&mut list, h2);

        day_05::complete_habit(&mut list, 1);

        let is_completed_bool = day_05::is_completed(&list, 1);
        assert_eq!(is_completed_bool, true);
    }
}