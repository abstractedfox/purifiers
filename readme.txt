Air Purifiers!

These are the portable air purifiers I designed for myself. I thought some other people might be able to make use of them, so here they are!


Required materials/resources:
- Filament 3D Printer
- 2x PC case fans per unit of the appropriate size and performance (strongly recommended to purchase ones with higher CFM and static pressure performance)
- One 'Pure Enrichment PureZone Mini' HEPA filter
- USB cable to power your fans (or however else you'd like to power them)
- Any USB power source
- Shoelaces (or whatever you want to hold them together, but I like shoelaces)


Design:
The goal with these was to prioritize performance against the usual constraints seen on commercially available portable purifiers (power consumption and noise); although I've gotten double digit hours using 60mm fans with a 20k-something mAH power bank, so, still not bad. Unlike off the shelf units, these aren't made to have a self-contained battery. They're intended to be straightforward to assemble with off the shelf, relatively inexpensive parts; there is certainly room to do better with more boutique components. If anyone experiments with that, I'd like to hear how it goes.

At the moment, both the 60mm and 120mm designs are sized to work with the same "Pure Enrichment PureZone Mini" filter. I used this one because it seems to go to the most popular commercial portable purifier at the moment, so, hopefully the filters are less likely to go out of production. My informal testing has shown that these filters are effective at filtering PM2.5, so while they don't have any certifications that I know of, we know they do filter the air (no, I don't have the facilities to test whether they truly meet HEPA spec, though there's some give and take on high filtration vs the limitation imposed by constraint of airflow anyway)


Code design:
With luck, these designs should be straightforward enough to modify to other filter sizes by someone who can program. Each design's "root.scad" file will contain parameters and modules that are common throughout a design, so that would be a good place to start for modifying one.
