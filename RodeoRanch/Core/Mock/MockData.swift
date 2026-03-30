import Foundation

enum MockData {

    // MARK: - Current user
    static let currentUser = User(
        id: "rider-001",
        firstName: "Jake",
        lastName: "Thornton",
        email: "jake@example.com",
        phone: "0412 345 678",
        membershipNumber: "AQHA-28441",
        roles: [.rider, .judge],
        clubId: "club-tamworth",
        clubName: "Tamworth Stockhorse Club",
        region: .nsw,
        avatarURL: nil,
        createdAt: Date()
    )

    // MARK: - Events
    static let events: [Event] = [
        Event(
            id: "evt-001",
            name: "Tamworth Spring Classic",
            discipline: .teamPenning,
            status: .live,
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
            venue: "Tamworth Showground, NSW",
            region: .nsw,
            entryFee: 85.00,
            maxEntries: 60,
            currentEntries: 48,
            description: "Annual spring classic. 3-person teams, 5-head cattle draw.",
            drawReleased: true,
            resultsPosted: false
        ),
        Event(
            id: "evt-002",
            name: "QLD Barrel Championship",
            discipline: .barrelRacing,
            status: .live,
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            venue: "Warwick Showground, QLD",
            region: .qld,
            entryFee: 65.00,
            maxEntries: 80,
            currentEntries: 72,
            description: "1D–4D speed divisions. Youth class included.",
            drawReleased: true,
            resultsPosted: false
        ),
        Event(
            id: "evt-003",
            name: "Outback Cutting Invitational",
            discipline: .cutting,
            status: .open,
            startDate: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
            endDate: Calendar.current.date(byAdding: .day, value: 16, to: Date())!,
            venue: "Longreach Showground, QLD",
            region: .qld,
            entryFee: 120.00,
            maxEntries: 40,
            currentEntries: 22,
            description: "NCHA-affiliated. Open + Non-Pro + Limited Non-Pro.",
            drawReleased: false,
            resultsPosted: false
        ),
        Event(
            id: "evt-004",
            name: "Hunter Valley Sorting",
            discipline: .sorting,
            status: .open,
            startDate: Calendar.current.date(byAdding: .day, value: 21, to: Date())!,
            endDate: Calendar.current.date(byAdding: .day, value: 21, to: Date())!,
            venue: "Maitland Equestrian Centre, NSW",
            region: .nsw,
            entryFee: 55.00,
            maxEntries: 30,
            currentEntries: 11,
            description: "2-person teams. Sort 1–13 numbered cattle.",
            drawReleased: false,
            resultsPosted: false
        ),
        Event(
            id: "evt-005",
            name: "VIC Open Rodeo",
            discipline: .rodeo,
            status: .open,
            startDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
            endDate: Calendar.current.date(byAdding: .day, value: 31, to: Date())!,
            venue: "Bendigo Showground, VIC",
            region: .vic,
            entryFee: 95.00,
            maxEntries: 100,
            currentEntries: 34,
            description: "Multi-discipline rodeo. Open + Amateur + Youth.",
            drawReleased: false,
            resultsPosted: false
        )
    ]

    // MARK: - My runs
    static let myRuns: [Run] = [
        Run(
            id: "run-001",
            eventId: "evt-001",
            eventName: "Tamworth Spring Classic",
            discipline: .teamPenning,
            riderId: "rider-001",
            riderName: "Jake Thornton",
            horseName: "Blue Moon",
            horseId: "horse-001",
            drawPosition: 12,
            scheduledTime: Calendar.current.date(byAdding: .hour, value: 2, to: Date()),
            status: .upcoming,
            result: nil,
            division: "Open",
            teamMembers: ["Sarah Collins", "Mike Reeves"]
        ),
        Run(
            id: "run-002",
            eventId: "evt-001",
            eventName: "Tamworth Spring Classic",
            discipline: .teamPenning,
            riderId: "rider-001",
            riderName: "Jake Thornton",
            horseName: "Blue Moon",
            horseId: "horse-001",
            drawPosition: nil,
            scheduledTime: nil,
            status: .completed,
            result: RunResult(
                time: 74.2,
                cattleCount: 3,
                judgeScore: nil,
                penalties: [],
                placing: 2,
                division: "Open",
                prizeAmount: 220.0,
                pointsEarned: 8.0
            ),
            division: "Open",
            teamMembers: ["Sarah Collins", "Mike Reeves"]
        ),
        Run(
            id: "run-003",
            eventId: "evt-003",
            eventName: "Outback Cutting Invitational",
            discipline: .cutting,
            riderId: "rider-001",
            riderName: "Jake Thornton",
            horseName: "Dusty Road",
            horseId: "horse-002",
            drawPosition: 8,
            scheduledTime: nil,
            status: .completed,
            result: RunResult(
                time: nil,
                cattleCount: nil,
                judgeScore: 73.5,
                penalties: [],
                placing: 1,
                division: "Non-Pro",
                prizeAmount: 450.0,
                pointsEarned: 10.0
            ),
            division: "Non-Pro",
            teamMembers: nil
        )
    ]

    // MARK: - Horses
    static let horses: [Horse] = [
        Horse(
            id: "horse-001",
            name: "Blue Moon",
            registrationNumber: "AQHA-88421",
            breed: "Quarter Horse",
            colour: "Blue Roan",
            sex: .gelding,
            yearOfBirth: 2016,
            ownerId: "rider-001",
            ownerName: "Jake Thornton",
            notes: "Excellent at penning. Slight issue with left shoulder — see vet notes.",
            isActive: true,
            photoURL: nil
        ),
        Horse(
            id: "horse-002",
            name: "Dusty Road",
            registrationNumber: "NCHA-44920",
            breed: "Quarter Horse",
            colour: "Buckskin",
            sex: .mare,
            yearOfBirth: 2018,
            ownerId: "rider-001",
            ownerName: "Jake Thornton",
            notes: "Cutting specialist. 3 x Non-Pro placings.",
            isActive: true,
            photoURL: nil
        )
    ]

    // MARK: - Leaderboard
    static let leaderboard = Leaderboard(
        id: "board-001",
        eventId: "evt-001",
        eventName: "Tamworth Spring Classic",
        discipline: .teamPenning,
        division: "Open",
        entries: [
            StandingsEntry(id: "s1", placing: 1, riderName: "Dave Wallis", horseName: "Rusty", division: "Open", score: "58.4 — 3 head", penalties: nil, teamName: "Team Wallis", isCurrentUser: false),
            StandingsEntry(id: "s2", placing: 2, riderName: "Jake Thornton", horseName: "Blue Moon", division: "Open", score: "74.2 — 3 head", penalties: nil, teamName: "Team Thornton", isCurrentUser: true),
            StandingsEntry(id: "s3", placing: 3, riderName: "Mia Chen", horseName: "Spirit", division: "Open", score: "81.0 — 3 head", penalties: nil, teamName: "Team Chen", isCurrentUser: false),
            StandingsEntry(id: "s4", placing: 4, riderName: "Sam Ford", horseName: "Copper", division: "Open", score: "42.1 — 2 head", penalties: nil, teamName: "Team Ford", isCurrentUser: false),
            StandingsEntry(id: "s5", placing: 5, riderName: "Kate Williams", horseName: "Shadow", division: "Open", score: "NT — 2 head", penalties: nil, teamName: "Team Williams", isCurrentUser: false)
        ],
        lastUpdated: Date()
    )

    // MARK: - Notifications
    static let notifications: [AppNotification] = [
        AppNotification(id: "n1", type: .drawReleased, title: "Draw released", body: "The draw for Tamworth Spring Classic has been released. You\'re run #12.", eventId: "evt-001", runId: nil, isRead: false, createdAt: Calendar.current.date(byAdding: .hour, value: -1, to: Date())!),
        AppNotification(id: "n2", type: .runUpNext, title: "You\'re up next!", body: "Run #11 is in the arena. Get ready at the gate.", eventId: "evt-001", runId: "run-001", isRead: false, createdAt: Calendar.current.date(byAdding: .minute, value: -10, to: Date())!),
        AppNotification(id: "n3", type: .entryConfirmed, title: "Entry confirmed", body: "Your entry for Outback Cutting Invitational has been confirmed and payment received.", eventId: "evt-003", runId: nil, isRead: true, createdAt: Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
    ]

    // MARK: - Penalties per discipline (for judge mode)
    static func penalties(for discipline: Discipline) -> [Penalty] {
        switch discipline {
        case .teamPenning:
            return [
                Penalty(id: "p1", name: "Wrong cattle", type: .disqualification, value: 0),
                Penalty(id: "p2", name: "Knocked barrel", type: .seconds, value: 5),
                Penalty(id: "p3", name: "Time out", type: .noTime, value: 0)
            ]
        case .cutting:
            return [
                Penalty(id: "p1", name: "Loss of cow", type: .points, value: 3),
                Penalty(id: "p2", name: "Herd hold violation", type: .points, value: 5),
                Penalty(id: "p3", name: "Illegal use of reins", type: .disqualification, value: 0)
            ]
        case .barrelRacing:
            return [
                Penalty(id: "p1", name: "Knocked barrel", type: .seconds, value: 5),
                Penalty(id: "p2", name: "Breaking pattern", type: .disqualification, value: 0),
                Penalty(id: "p3", name: "Failure to complete", type: .noTime, value: 0)
            ]
        case .sorting:
            return [
                Penalty(id: "p1", name: "Wrong number sorted", type: .disqualification, value: 0),
                Penalty(id: "p2", name: "Cattle back through gate", type: .seconds, value: 5),
                Penalty(id: "p3", name: "Time out", type: .noTime, value: 0)
            ]
        case .rodeo:
            return [
                Penalty(id: "p1", name: "Equipment failure", type: .reRide, value: 0),
                Penalty(id: "p2", name: "Refusal", type: .seconds, value: 5),
                Penalty(id: "p3", name: "Fall from horse", type: .disqualification, value: 0)
            ]
        }
    }
}
