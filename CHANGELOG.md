# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] 2016-09-02
### Added
Initial release. Parse RSS feeds.

## [0.2.0] 2016-09-13
### Added
New entry field, imageUrl, for RSS entry ```media:content -> url```

## [0.3.0] 2017-06-28 
### Changed
Fix issue with entry without media:content element.
Fix parsing HTML characters.

## [0.4.0] 2017-09-01
### Added 
New HTML chars to replace (<, > and @)

### Fixed 
Memory usage by using NSMutableString
