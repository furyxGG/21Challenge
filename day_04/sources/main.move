/// DAY 4: Vector + Ownership Basics
/// 
/// Today you will:
/// 1. Learn about vectors
/// 2. Create a list of habits
/// 3. Understand basic ownership concepts

module challenge::day_04 {
    use std::vector;
    use std::string::String;

    // Copy the Habit struct from day_03
    public struct Habit has copy, drop {
        name: String,
        completed: bool,
    }

    public fun new_habit(name: String): Habit {
        Habit {
            name,
            completed: false,
        }
    }

    // TODO: Create a struct called 'HabitList' with:
    // - habits: vector<Habit>
    // Add 'drop' ability (not copy, because vectors can't be copied)
    // public struct HabitList has drop {
    //     // Your field here
    // }

    public struct HabitList has drop {
        habits: vector<Habit>,
    }

    // TODO: Write a function 'empty_list' that returns an empty HabitList
    // public fun empty_list(): HabitList {
    //     // Use vector::empty() to create an empty vector
    // }

    public fun empty_list(): HabitList {
        HabitList {
            habits: vector::empty(),
        }
    }

    // TODO: Write a function 'add_habit' that takes:
    // - list: &mut HabitList (mutable reference)
    // - habit: Habit (by value, transfers ownership)
    // Use vector::push_back to add the habit
    // public fun add_habit(list: &mut HabitList, habit: Habit) {
    //     // Your code here
    // }

    public fun add_habit(list: &mut HabitList, habit: Habit) {
        vector::push_back(&mut list.habits, habit);
    }

    #[test]
    public fun get_length(list: &HabitList): u64 {
        vector::length(&list.habits)
    }
}

#[test_only]
module challenge::day_04_tests {
    use std::string;
    use std::vector;
    use challenge::day_04::{Self, HabitList, Habit};
    use std::unit_test::assert_eq;

    #[test]
    fun test_habit_flow() {
        // direkt değişkeni fonksiyona vermek demek ben ya o değişkeni sileceğim ya da sahipliğini değiştireceğim demek.
        // & ile kullanmak, salt okunur hale getirmek demek. get_lenght fonksiyonunda kullandığımız gibi.
        // &mut ile kullanmak ise direkt c dilindeki pointer vermek gibi. yani ben içinde değişiklik vs yapacağım haberin olsun.
        let mut list = day_04::empty_list();
        

        let h1 = day_04::new_habit(string::utf8(b"Su Ic"));
        let h2 = day_04::new_habit(string::utf8(b"Kod Yaz"));

        day_04::add_habit(&mut list, h1); // içine eleman ekliyoruz o yüzden &mut var
        day_04::add_habit(&mut list, h2);

        let val: u64 = day_04::get_length(&list); // uzunluk alıyoruz, yani sadece okuyoruz. o yüzden sadece & var. eğer onu da koymasaydık bu fonksiyondan sonra list e erişemezdik.
        assert_eq!(val, 2); // burada da val değişkenimiz 2 ye eşit mi değil mi ona bakıyoruz.
    }
}