<script>
	let { children } = $props();
</script>

<nav>
	<a href="/">home</a>
	<a href="/about">about</a>
    <a href="/account">account</a>
</nav>

{@render children()}