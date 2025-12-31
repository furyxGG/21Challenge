/// DAY 15: Read Object Model & Create FarmState Struct (no UID yet)
/// 
/// Today you will:
/// 1. Learn about Sui objects (conceptually)
/// 2. Create a simple struct for farm counters
/// 3. Write basic functions to increment counters
/// 
/// NOTE: Today we're NOT creating a Sui object yet, just a regular struct.
/// We'll add UID and make it an object tomorrow.

module challenge::day_15 {
    // TODO: Define constants for plotId validation
    // const MAX_PLOTS: u64 = 20;
    // const E_PLOT_NOT_FOUND: u64 = 1;
    // const E_PLOT_LIMIT_EXCEEDED: u64 = 2;
    // const E_INVALID_PLOT_ID: u64 = 3;
    // const E_PLOT_ALREADY_EXISTS: u64 = 4;

    const MAX_PLOTS: u64 = 20;
    const E_PLOT_NOT_FOUND: u64 = 1;
    const E_PLOT_LIMIT_EXCEEDED: u64 = 2;
    const E_INVALID_PLOT_ID: u64 = 3;
    const E_PLOT_ALREADY_EXISTS: u64 = 4;

    // TODO: Define a struct called 'FarmCounters' with:
    // - planted: u64
    // - harvested: u64
    // - plots: vector<u8>
    // Add 'copy', 'drop', and 'store' abilities
    // (store is needed because we'll put this in an object later)
    // public struct FarmCounters has copy, drop, store {
    //     // Your fields here
    // }

    public struct FarmCounters has copy, drop, store {
        planted: u64,
        harvested: u64,
        plots: vector<u8>
    }

    // TODO: Write a constructor 'new_counters' that returns counters with zeros
    // fun new_counters(): FarmCounters {
    //     // Your code here (include plots: vector::empty())
    // }

    fun new_counters(): FarmCounters {
        FarmCounters {
            planted: 0,
            harvested: 0,
            plots: vector::empty()
        }
    }

    // TODO: Write a function 'plant' that takes plotId: u8 and increments planted counter
    // fun plant(counters: &mut FarmCounters, plotId: u8) {
    //     // Your code here
    //     // Validate plotId, check limits, prevent duplicates
    // }

    fun plant(counters: &mut FarmCounters, plotId: u8) {
        // ilk olarak güvenlik açısından kontrol yapmamız lazım
        assert!(plotId >= 1 || plotId <= (MAX_PLOTS as u8), E_INVALID_PLOT_ID);
        let len: u64 = vector::length(&counters.plots);
        assert!(len < MAX_PLOTS, E_PLOT_LIMIT_EXCEEDED);

        let mut a: u64 = 0;
        while (a < len) {
            let plot = vector::borrow(&counters.plots, a);
            assert!(*plot != plotId, E_PLOT_ALREADY_EXISTS);
            a = a + 1;
        };
        counters.planted = counters.planted + 1;
        vector::push_back(&mut counters.plots, plotId);
    }

    // TODO: Write a function 'harvest' that takes plotId: u8 and increments harvested counter
    // fun harvest(counters: &mut FarmCounters, plotId: u8) {
    //     // Your code here
    //     // Find and remove the plot from the vector
    // }

    fun harvest(counters: &mut FarmCounters, plotId: u8) {
        let len: u64 = vector::length(&counters.plots);

        let mut a: u64 = 0;
        let mut checker: u64 = len;
        while (a < len) {
            let plot = vector::borrow(&counters.plots, a);
            if (*plot == plotId) {
                checker = a;
            };
            a = a + 1;
        };
        assert!(checker < len , E_PLOT_NOT_FOUND);

        vector::remove(&mut counters.plots, checker);
        counters.harvested = counters.harvested + 1;
    }
}

