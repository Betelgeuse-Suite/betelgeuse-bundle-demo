declare namespace Beetlejuice {
    interface MyApp {
        "": {
            "index": {
                "source": string;
                "test": string;
                "test2": string;
            };
            "nested": {
                "file": {
                    "value": number;
                };
            };
        };
    }
}
export = Beetlejuice;