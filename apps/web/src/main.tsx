import { render } from 'preact';

function App() {
  return (
    <main>
      <p>HelpingPeopleNow</p>
      <h1>Encuentra ayuda para tu hogar</h1>
      <p>Application scaffold. The first user journey will be added through OpenSpec.</p>
    </main>
  );
}

render(<App />, document.getElementById('app')!);
