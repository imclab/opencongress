#!/usr/bin/env ruby

people = Person.all_voting
i = 0
people.each do |p|
  i += 1

  unless p.person_stats
    p.create_person_stats
  end

  PersonStats.transaction {
    puts "Calculating voting similarites for #{p.name} (#{i}/#{people.size})"

    top_votes_with, top_votes_apart = p.most_and_least_voting_similarities

    #puts "Top With:\n"
    #top_votes_with.each { |w| puts "#{w[0].name}\t\t#{w[1]}" }
    #puts "\n\nTop Apart:\n"
    #top_votes_apart.each { |w| puts "#{w[0].name}\t\t#{w[1]}" }

    if top_votes_with && top_votes_with[0]
      p.person_stats.votes_most_often_with = top_votes_with[0]
      puts "#{p.name} votes most often with #{top_votes_with[0].name}"
    end

    if top_votes_apart && top_votes_apart[0]
      p.person_stats.votes_least_often_with = top_votes_apart[0]
      puts "#{p.name} votes least often with #{top_votes_apart[0].name}"
    end

    if p.belongs_to_major_party?
      top_other_with = (top_votes_with.select { |a| a.party == p.opposing_party})[0]
      top_same_apart = (top_votes_apart.select { |a| a.party == p.party})[0]

      if top_other_with
        p.person_stats.opposing_party_votes_most_often_with = top_other_with
        puts "#{p.name} opposite votes most often with #{top_other_with.name}"
      end

      if top_same_apart
        p.person_stats.same_party_votes_least_often_with = top_same_apart
        puts "#{p.name} same votes least often with #{top_same_apart.name}"
      end
    end

    p.stats.save!
  }
end





