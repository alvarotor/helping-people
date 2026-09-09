import { render } from 'preact';

function App() {
  return (
    <main>
      <p>HelpingPeopleNow Admin</p>
      <h1>Operations console scaffold</h1>
      <p>Administrative features will be added through approved OpenSpec changes.</p>
    </main>
  );
}

render(<App />, document.getElementById('app')!);
