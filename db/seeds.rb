# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Candidate.delete_all

Candidate.create({
  name: "Donald Trump",
  party: "Republican",
  subtitle: "Republican | Businessman",
  blob: "Donald Trump is a businessman, politician, and television personality. He is the chairman and president of The Trump Organization and the founder of Trump Entertainment Resorts. He is most well known for his luxurious real estate projects, including Trump Tower, and his reality shows, such as \"The Apprentice\". He first showed his interest in the presidential office by running  as a candidate in 2000 as part of the Reform party. He announced his candidacy for the current election on June 2016, as part of the Republican party",
  policies:  ["Repeal Affordable Care Act", "Build a wall across the Mexcian border", "Deport criminal illegal aliens", "End birthright citizenship", "Reform trade with China"],
})

Candidate.create({
  name: "Ted Cruz",
  party: "Republican",
  subtitle: "Republican | Senator, Texas",
  blob: "Ted Cruz is a politician and the junior United States Senator from Texas. He studied at Princeton University and proceeded to obtain his law degree from Harvard. He has served as the director of the Office of Policy at the Federal Trade Commission, an associate deputy attorney general at the United States Department of Justice, and a policy advisor to George W. Bush during his presidential campaign. He has also been the longest served Solicitor General of Texas",
  policies:  ["Repeal Affordable Care Act", "Build walls along Mexican border", "Increase deportations for illegal aliens", "Temporary Freeze on Legal Immigration", "Rebuild Military", "Flat tax rate of 10%"],
})

Candidate.create({
  name: "Marco Rubio",
  party: "Republican",
  subtitle: "Republican | Senator, Florida",
  blob: "Marco Rubio is an attorney, politician and the junior United States Senator from Florida. He holds degrees from the University of Florida and the University of Miami School of Law. He has previously served as the Speaker of the Florida House of Representatives, City Commissioner for West Miami, and the Florida House Majority Leader.",
  policies:  ["Repeal Affordable Care Act", "Repeal Estate Tax", "Cut Tax for Small Businesses", "Stop Eminent Domain abuse", "Approve Keystone XL Pipeline", "Deport criminal illegal aliens", "Build walls along Mexican border"],
})

Candidate.create({
  name: "Hillary Clinton",
  party: "Democratic",
  subtitle: "Democrat | Secretary of State",
  blob: "Hillary Clinton is a politician who holds degrees from Wellesly College and Yale Law School. She has served as the United States Secretary of State, a United States Senator, and the First Lady of the United States. She has also been a partner at Rose Law Firm, and a board member at various public corporations. She was a Democratic candidate for the 2008 election against President Obama",
  policies: ["Overturn Citizens United", "Bring GHG emissions down", "Make education affordable", "Tax relief for working families", "Create pathway to citizenship for illegal aliens", "Raise the minimum wage"],
})

Candidate.create({
  name: "Bernie Sanders",
  party: "Democratic",
  subtitle: "Democrat | Senator, Vermont",
  blob: "Bernie Sanders is a politician and the junor United States Senator from Vermont. He holds a degree from the University of Chicago. He has served as the mayor of Burlington, Vermont for four consecutive terms, as a United States Congressman for 16 years, and has been a senator since 2006.",
  policies:  ["Progressive Estate Tax", "Increase minimum wage", "Rebuild infrastructure", "Reverse trade policies like NAFTA", "Make tuition free", "Break up huge financial institutions", "Make healthcare a right and more affordable"],
})
