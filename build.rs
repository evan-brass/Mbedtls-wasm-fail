use eyre::Result;
use std::path::PathBuf;

fn main() -> Result<()> {
	let out_path = PathBuf::from(std::env::var("OUT_DIR")?);
	let manifest_dir = PathBuf::from(std::env::var("CARGO_MANIFEST_DIR")?);

	let include_arg = format!("-I{}", manifest_dir.join("include").to_str().unwrap());
	let sysroot_arg = format!("--sysroot={}", manifest_dir.join("wasi-sysroot").to_str().unwrap());

	// Compile mbedtls
	let dst = cmake::Config::new("vendor")
		.cflag("--compile")
		.cflag(&include_arg)
		.cflag(sysroot_arg)
		.cflag(r#"-DMBEDTLS_CONFIG_FILE=\"config.h\""#)
		.define("ENABLE_PROGRAMS", "OFF")
		.define("ENABLE_TESTING", "OFF")
		.define("MBEDTLS_FATAL_WARNINGS", "OFF")
		.define("USE_SHARED_MBEDTLS_LIBRARY", "ON")
		.define("USE_STATIC_MBEDTLS_LIBRARY", "OFF")
		.build();
	
	// println!("cargo:rustc-link-search=native={}", dst.join("lib").to_str().unwrap());
	// println!("cargo:rustc-link-lib=mbedcrypto");
	// println!("cargo:rustc-link-lib=mbedx509");
	// println!("cargo:rustc-link-lib=mbedtls");
	
	// // Generate bindings for the three libraries:
	// let out_include = format!("-I{}", out_path.join("include").to_str().unwrap());
	// let bindings = bindgen::builder()
	// 	.clang_arg(out_include)
	// 	.clang_arg(include_arg)
	// 	// .clang_arg(r#"-DMBEDTLS_CONFIG_FILE=config.h"#)
	// 	// .allowlist_function("mbedtls.*")
	// 	// .allowlist_function("psa.•")
	// 	// .allowlist_var("MBEDTLS.*")
	// 	// .allowlist_var("PSA.*")
	// 	.header("include/wrapper.h")
	// 	.generate()?;
	// bindings.write_to_file(out_path.join("bindings.rs"))?;

	Ok(())
}
