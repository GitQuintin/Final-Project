using .PlayingCards
using Test

#Hands for testing
royal_flush_1 = Hand("T♠,J♠,Q♠,K♠,A♠");
straight_flush_1 = Hand("2♡,3♡,4♡,5♡,6♡");
flush_1 = Hand("2♣,7♣,T♣,3♣,A♣");
straight_1 = Hand("4♣,5♠,6♠,7♢,8♣");
four_of_a_kind_1 = Hand("2♠,5♠,5♢,5♣,5♡");
full_house_1 = Hand("4♣,4♢,4♠,7♣,7♢");
full_house_2 = Hand("4♣,4♢,7♠,7♣,7♢");
three_of_a_kind_1 = Hand("4♠,4♢,4♣,A♠,7♡");
two_pair_1 = Hand("4♣,4♢,5♠,7♣,7♢");
one_pair_1 = Hand("2♠,2♢,5♣,8♢,Q♣");
nothing_hand = Hand("T♣,4♢,Q♠,3♣,6♢");


#Card Constructors
@testset "Legal Card Constructor" begin
    @test isa(Card(1,3),Card)
    @test isa(Card(45),Card)
    @test isa(Card("3\u2660"),Card)
    @test isa(Card("T♣"),Card)
end
@testset "Illegal Cards throws exceptions" begin
    @test_throws ArgumentError Card(0,3)
    @test_throws ArgumentError Card(14,2)
    @test_throws ArgumentError Card(1,0)
    @test_throws ArgumentError Card(0,5)
    @test_throws ArgumentError Card("AS")
end

#Hand Constructors
@testset "Legal Hand Constructor" begin
    @test isa(Hand([Card(4,1),Card(4,2),Card(4,3),Card(7,3),Card(7,4)]),Hand)
    @test isa(Hand(["2♢","Q♠","T♠","T♣","5♡"]),Hand)
    @test isa(Hand("3♠,4♢,A♠,A♣,K♡"),Hand)
    
end
@testset "Illegal Hand throws exceptions" begin
    @test_throws ArgumentError Hand([Card(0,3),Card(2,2),Card(4,3),Card(10,2),Card(13,1)]) # card rank not legal
    @test_throws ArgumentError Hand([Card(1,5),Card(2,2),Card(4,3),Card(10,2),Card(13,1)]) #card suit not legal
    @test_throws ArgumentError Hand([Card(1,0),Card(2,2),Card(4,3),Card(10,2),Card(13,1)]) # card suit not legal
    @test_throws ArgumentError Hand(["2♢","QD","T♠","T♣","5♡"]) # card suit not legal
    @test_throws ArgumentError Hand(["2♢","Q♢","T♠","T♣","1♡"]) # card rank not legal
end

@testset "Full House" begin
    @test isFullHouse(full_house_1)
    @test isFullHouse(full_house_2)
    @test !isFullHouse(three_of_a_kind_1)
end

@testset "One Suit" begin
    @test isOneSuit(royal_flush_1)
    @test isOneSuit(straight_flush_1)
    @test !isOneSuit(three_of_a_kind_1)
end

@testset "Run" begin
    @test isRun(royal_flush_1)
    @test isRun(straight_1)
    @test !isRun(nothing_hand)
end

@testset "Royal Flush" begin
    @test isRoyalFlush(royal_flush_1)
    @test !isRoyalFlush(straight_flush_1)
end

@testset "Two Pairs" begin
    @test isTwoPair(two_pair_1)
    @test !isTwoPair(one_pair_1)
end

@testset "Straight Flush" begin
    @test isStraightFlush(straight_flush_1)
    @test !isStraightFlush(straight_1)
end

@testset "Straight" begin
    @test isStraight(straight_1)
    @test !isStraight(royal_flush_1)
end

@testset "Flush" begin
    @test isFlush(flush_1)
    @test !isFlush(straight_1)
end

@testset "Four of a kind" begin
    @test isFourKind(four_of_a_kind_1)
    @test !isFourKind(three_of_a_kind_1)
end

@testset "Three of a kind" begin
    @test isThreeKind(three_of_a_kind_1)
    @test !isThreeKind(four_of_a_kind_1)
end