BEGIN {
	NULL_CHARACTER = "$"
}

{
	if (NR == 1) {
		if (NF == 1) {
			tape = $1
		} else {
			print "Illegal tape"
			exit
		}
	}

	if (NR == 2) {
		if (NF == 3) {
			state = $1
			end_state = $2
			position = $3
		} else {
			print "Illegal initial state, end state and initial position"
			exit
		}
	}

	if (NR > 2 && (NF == 4 || NF == 5)) {
		control[NR - 2, 1] = $1
		control[NR - 2, 2] = $2
		control[NR - 2, 3] = $3
		control[NR - 2, 4] = $4
		control[NR - 2, 5] = $5
	}
}

END {
	if ((length(control) < 5) || (length(control) % 5 != 0)) {
		print "Illegal control elements"
		exit
	}

	while (1) {
		if (state == end_state) {
			print "End state reached: ", tape
			exit
		}

		if ((position < 1) || position > length(tape)) {
			character = NULL_CHARACTER
		} else {
			character = substr(tape, position, 1)
		}

		for (i = 1; i <= (length(control) / 5); i++) {
			if ((control[i, 1] == state) && (control[i, 2] == character)) {
				offset = 0

				if (control[i, 4] == "L") {
					offset = -1
				} else if (control[i, 4] == "R") {
					offset = 1
				} else if (control[i, 4] == "N") {
					offset = 0
				} else {
					print "Illegal movement: ", control[i, 4]
					exit
				}

				if ((position < 1) && (control[i, 5] != "")) {
					tape = control[i, 5] tape
					offset += 1
				} else if ((position > length(tape)) && (control[i, 5] != "")) {
					tape = tape control[i, 5]
				} else if (control[i, 5] != "") {
					tape = substr(tape, 1, position - 1) control[i, 5] substr(tape, position + 1)
				}

				position += offset
				state = control[i, 3]
				break
			}
		}

		if (i > (length(control) / 5)) {
			print "Could not find matching control element: ", state, character
			exit
		}
	}
}
