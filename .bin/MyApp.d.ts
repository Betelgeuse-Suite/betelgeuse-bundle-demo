declare namespace Beetlejuice {
    interface MyApp {
        "index": {
            "source": string;
            "test": string;
            "test1": string;
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