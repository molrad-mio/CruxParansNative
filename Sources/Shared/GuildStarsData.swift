import Foundation

public struct GuildStar {
    public let name: String
    public let emoji: String
    public let title: String
    public let flavorText: String
}

public struct GuildStarsData {
    public static let stars: [GuildStar] = [
        GuildStar(name: "Canopus", emoji: "🕯️", title: "The Eternal Navigator", flavorText: """
Thou art locked by the star of profound wisdom and eternal navigation, quietly dwelling at the very edge of the horizon.
Distance thyself from the clamor of the mundane world; remain a silent observer who sees through the entirety of existence, and perfect thine own truth.
"""),
        GuildStar(name: "Capella", emoji: "🐐", title: "The Independent Sovereign", flavorText: """
Thou art locked by the star of absolute independence and freedom, shining nobly in the northern sky.
Sovereign and unbound by the chains of any authority or organization, become a warrior of liberty who soars through the vast heavens upon thine own wings.
"""),
        GuildStar(name: "Vega", emoji: "🎻", title: "The Supreme Artist", flavorText: """
Thou art locked by the star of supreme artistry and mesmerizing charisma, radiating brilliance by the Celestial River.
Captivate and intoxicate the minds of men with the overwhelming beauty and talent thou wieldest, and repaint this earthly realm into something beautiful.
"""),
        GuildStar(name: "Altair", emoji: "🦅", title: "The Courageous Pioneer", flavorText: """
Thou art locked by the star of unyielding courage and lofty flight, sharply cleaving the great skies.
Possess the resilient will of an eagle that fears no storm, and become a pioneer who opens paths through uncharted wilderness.
"""),
        GuildStar(name: "Deneb", emoji: "🦢", title: "The Imperishable Inquirer", flavorText: """
Thou art locked by the star of far-reaching intellect and imperishable inquiry, peering even unto the ends of the galaxy.
Despise the transient fashions of the mundane world, and weave with thine own hands a crystal of truth that shall not fade for centuries to come.
"""),
        GuildStar(name: "Arcturus", emoji: "🏹", title: "The Vanguard of Transformation", flavorText: """
Thou art locked by the vanguard star of transformation, burning fiercely—the trailblazer of a new era.
Break down ancient conventions, stand at the forefront of the people, and found an empire in a dangerous, uncharted world that no man hath yet witnessed.
"""),
        GuildStar(name: "Achernar", emoji: "💧", title: "The Lofty Spirit", flavorText: """
Thou art locked by the star of lofty spirituality and ultimate salvation, flowing at the end of the Celestial River.
Maintain thy dignity no matter what crisis surrounds thee, and transcend thy cruel destiny through the power of prayer and the spirit.
"""),
        GuildStar(name: "Pollux", emoji: "🥊", title: "The Cold Insight", flavorText: """
Thou art locked by the star of cold insight and unyielding struggle, gouging out the essence hidden within the darkness.
Cast away pleasant platitudes; though it may bring immense pain, continue to stare directly at the stark, naked reality of this world with both thine eyes.
"""),
        GuildStar(name: "Denebola", emoji: "🦁", title: "The Proud Outcast", flavorText: """
Thou art locked by the star of noble rebellion and unorthodox wisdom, burning at the tail of the Lion.
Refuse to conform to the dull traditions of the masses; walk thy solitary path as a proud outcast to redefine the era.
"""),
        GuildStar(name: "Scheat", emoji: "💎", title: "The Untamed Innovator", flavorText: """
Thou art locked by the star of untamed intellect and turbulent creation, soaring within the Great Square of the heavens.
Break the mental cages of mankind; let thy wild, unbridled ideas flood this world and birth a new paradigm.
"""),
        
        // Royal Stars Placeholder
        GuildStar(name: "Aldebaran", emoji: "👁️", title: "The Watcher of the East", flavorText: """
Thou art locked by the Royal Star of the East, bearing the weight of immense integrity and martial glory.
Honor thy principles above all, for thy foundation is built upon unwavering truth.
"""),
        GuildStar(name: "Antares", emoji: "🦂", title: "The Watcher of the West", flavorText: """
Thou art locked by the Royal Star of the West, harboring the intense fire of obsession and profound transformation.
Command the depths of thy desires, or be consumed by the very flames thou wieldest.
"""),
        GuildStar(name: "Regulus", emoji: "👑", title: "The Watcher of the North", flavorText: """
Thou art locked by the Royal Star of the North, wearing the crown of majestic kingship and supreme glory.
Rule with a magnanimous heart, but beware the shadow of vengeance that threatens to dethrone thee.
"""),
        GuildStar(name: "Fomalhaut", emoji: "🐟", title: "The Watcher of the South", flavorText: """
Thou art locked by the Royal Star of the South, embodying noble ideals and poetic mysticism.
Stay true to thy purest visions, lest thy dreams dissolve into deceit and illusion.
"""),
        
        // Notable Mentions
        GuildStar(name: "Spica", emoji: "🌾", title: "The Blessed Harvest", flavorText: """
Thou art locked by the star of brilliant gifts and ultimate salvation.
Thy mere presence brings forth abundance; use thy divine brilliance to illuminate the world.
"""),
        GuildStar(name: "Algol", emoji: "👁️‍🗨️", title: "The Dark Creator", flavorText: """
Thou art locked by the star of profound destruction and explosive creation.
Harness the darkest forces within, and forge a terrifying yet irresistible beauty from the chaos.
""")
    ]
    
    public static let noneStar = GuildStar(name: "None", emoji: "🌌", title: "The Absolute Void", flavorText: """
The star that locks thy soul exists nowhere in the firmament. Thou belongest to no faction of the gods; thou art a person of the absolute Void.
Like an anchorless ship, become thine own compass and sail solitary across the vast seas of absolute freedom, unblemished by any color.
""")
    
    public static func getGuildStar(forName name: String) -> GuildStar? {
        return stars.first(where: { $0.name.lowercased() == name.lowercased() })
    }
}
