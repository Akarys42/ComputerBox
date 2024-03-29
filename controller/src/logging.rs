use simplelog::{TermLogger, LevelFilter, ConfigBuilder, TerminalMode, ColorChoice};
use log::SetLoggerError;

pub fn init_logging(level: LevelFilter) -> Result<(), SetLoggerError> {
    TermLogger::init(
        level,
        ConfigBuilder::new()
            .set_time_level(LevelFilter::Off)
            .set_location_level(LevelFilter::Off)
            .set_target_level(LevelFilter::Off)
            .build(),
        TerminalMode::Stdout,
        ColorChoice::Auto
    )
}