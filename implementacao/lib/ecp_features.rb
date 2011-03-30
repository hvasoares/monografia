class EcpFeatures
	def do_search
	 resultado = []
	 Dir.foreach('./features') {|filename|
	  if filename =~ /\.feature$/
	   arquivo = File.open("./features/#{filename}")
	   if arquivo.read =~ /@ecp/
	    resultado.push(filename)
	   end
	  end
	 }

	 return resultado
	end
end
