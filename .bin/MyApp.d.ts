declare namespace Beetlejuice {
    interface MyApp {
        "nested": {
            "nested": {
                "file": {
                    "value": number;
                };
            };
        };
        "index": {
            "source": string;
            "test": string;
            "test2": string;
        };
    }
}
export = Beetlejuice;