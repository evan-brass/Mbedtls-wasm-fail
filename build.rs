use eyre::Result;

fn main() -> Result<()> {

	let comp = cc::Build::new().get_compiler();
	println!("{comp:?}");

	Ok(())
}
