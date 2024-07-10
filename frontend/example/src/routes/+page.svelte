<script lang="ts">
	import { getMessage } from '$lib/greeting/client';
	let greeting: string = 'Press Button For a Greeting';

	const handleClick = async () => {
		sendMessage();
	};

	const sendMessage = async () => {
		try {
			const res = await getMessage('test');
			greeting = res;
		} catch (err) {
			const error = err instanceof Error ? err.message : 'An unknown error occurred';
			console.error(error);
		}
	};
</script>

<p>{greeting}</p>
<button on:click={handleClick}>Generate Greeting!</button>
