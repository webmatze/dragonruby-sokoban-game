# frozen_string_literal: true

require './lib/normalize'

RSpec.describe Normalize do
  describe '.get_player_pos' do
    it 'finds correct coordinates of player' do
      data = [
        '   '.split(''),
        ' @ '.split(''),
        '   '.split('')
      ]
      expect(described_class.get_player_pos(data)).to eql([1, 1])
    end
  end

  describe '#call' do
    let(:xsb) do
      [
        '########',
        '# ..#  #',
        '# ..# $###',
        '#  ##    #',
        '## $   $ #',
        ' # ##  ###',
        ' #   $##',
        ' ###  #',
        '   #@ #',
        '   ####'
      ].join("\n")
    end
    let(:expected_result) do
      [
        '########__',
        '#-..#--#__',
        '#-..#-$###',
        '#--##----#',
        '##-$---$-#',
        '_#-##--###',
        '_#---$##__',
        '_###--#___',
        '___#@-#___',
        '___####___'
      ].map { |row| row.split('') }
    end
    let(:result) { described_class.call(xsb) }

    it 'returns an Array' do
      expect(result).to be_an(Array)
    end

    it 'normalizes data' do
      expect(result).to eql(expected_result)
    end
  end
end
