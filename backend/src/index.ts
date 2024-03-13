import { Card } from "./utils/card";
import express, { Request, Response } from "express";
import cors from "cors";

const app = express();
const port = 3000;

const cards: Card[] = [
  {
    id: 1,
    term: "Git was created by Linus Torvalds",
    definition: "True",
  },
  {
    id: 2,
    term: "HTTP stands for HyperText Transfer Protocol",
    definition: "True",
  },
  {
    id: 3,
    term: "HTTP is a secure protocol",
    definition: "False",
  },
  {
    id: 4,
    term: "Computer Science is the best major",
    definition: "True",
  },
];

const deck = { cards: cards };

app.use(cors());
app.use(express.json());

app.get("/", (_: Request, res: Response) => {
  res.send("Hello from NER + OASIS Swift Backend!");
});

app.post("/card", (req: Request, res: Response) => {
  try {
    const { body } = req;

    if (!body.term || !body.definition) {
      throw new Error("Invalid card, must have term and definition fields");
    }

    const card: Card = {
      id: cards.length + 1,
      term: body.term,
      definition: body.definition,
    };

    cards.push(card);
    res.send(JSON.stringify(deck));
  } catch (e: unknown) {
    if (e instanceof Error) {
      res.status(400).send(e.message);
    } else {
      res.status(500).send("An unknown error occurred");
    }
  }
});

app.delete("/card/:id", (req: Request, res: Response) => {
  try {
    const { id } = req.params;

    const cardId = parseInt(id, 10);
    if (isNaN(cardId)) {
      throw new Error("Id must be a number");
    }

    const index = cards.findIndex((card) => card.id === cardId);
    if (index === -1) {
      throw new Error(`Card with id: ${id} not found`);
    } else {
      cards.splice(index, 1);
      res.send(JSON.stringify(deck));
    }
  } catch (e: unknown) {
    if (e instanceof Error) {
      res.status(400).send(e.message);
    } else {
      res.status(500).send("An unknown error occurred");
    }
  }
});

app.get("/deck", (_: Request, res: Response) => {
  /* sleep for 5 seconds */
  const start = Date.now();
  while (Date.now() - start < 5000) {
    // do nothing
  }
  res.send(JSON.stringify(deck));
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
