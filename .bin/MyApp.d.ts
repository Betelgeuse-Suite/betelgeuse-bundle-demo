declare namespace Beetlejuice {
    interface MyApp {
        "index": {
            "source": string;
            "test": string;
            "test3": string;
        };
        "nested": {
            "nested": {
                "file": {
                    "value": number;
                };
            };
        };
    }
}
export = Beetlejuice;