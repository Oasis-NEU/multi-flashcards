import { Card } from "./utils/card"
import express, { Request, Response } from 'express'
import cors from 'cors'

const app = express()
const port = 3000

const cards : Card[] = [{term: "Git was created by Linus Torvalds", definition: "True"}, {term: "HTTP stands for HyperText Transfer Protocol", definition: "True"}, {term: "HTTP is a secure protocol", definition: "False"}, {term: "Computer Science is the best major", definition: "True"}]

const deck = {cards: cards}

app.use(cors());
app.use(express.json());

app.get('/', (_: Request, res: Response) => {
  res.send('Hello from NER + OASIS Swift Backend!')
});

app.get('/deck', (_: Request, res: Response) => {
  /* sleep for 5 seconds */
  const start = Date.now();
  while (Date.now() - start < 5000) {
    // do nothing
  }
  res.send(JSON.stringify(deck))
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
