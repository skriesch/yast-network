# Copyright (c) [2019] SUSE LLC
#
# All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, contact SUSE LLC.
#
# To contact SUSE LLC about this file by physical or electronic mail, you may
# find current contact information at www.suse.com.

require_relative "../test_helper"
require "y2network/routing_table"
require "y2network/routing"

describe Y2Network::Routing do
  subject(:routing) { described_class.new(tables: [table1])}
  let(:table1) { Y2Network::RoutingTable.new([route1]) }
  let(:route1) { double("Y2Network::Route") }

  describe "#==" do
    let(:other) { described_class.new(tables: [table1])}

    context "given two routing settings with the same values" do
      it "returns true" do
        expect(routing).to eq(other)
      end
    end

    context "when ipv4 forwarding setting are different" do
      before do
        other.forward_ipv4 = !routing.forward_ipv4
      end

      it "returns false" do
        expect(routing).to_not eq(other)
      end
    end

    context "when ipv6 forwarding setting are different" do
      before do
        other.forward_ipv6 = !routing.forward_ipv6
      end

      it "returns false" do
        expect(routing).to_not eq(other)
      end
    end

    context "when routing tables are different" do
      let(:table2) { Y2Network::RoutingTable.new([]) }
      let(:other) { described_class.new(tables: [table2]) }

      it "returns false" do
        expect(routing).to_not eq(other)
      end
    end
  end
end
