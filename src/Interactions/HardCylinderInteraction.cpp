/*
 * HardCylinderInteraction.cpp
 *
 *  Created on: 31/Oct/2013
 *      Author: Flavio 
 */

#include "HardCylinderInteraction.h"

HardCylinderInteraction::HardCylinderInteraction() :
				BaseInteraction<HardCylinderInteraction>() {
	this->_int_map[HardCylinder] = &HardCylinderInteraction::_hc_pot;
}

HardCylinderInteraction::~HardCylinderInteraction() {

}

void HardCylinderInteraction::get_settings(input_file &inp) {
	IBaseInteraction::get_settings(inp);
	char tmps[512];
	getInputString(&inp, "sim_type", (char *) tmps, 1);
	if(strncmp(tmps, "MC", 512)) throw oxDNAException("Cannot run Hard Cylinders with MD");

	float tmpf;
	getInputFloat(&inp, "height", &tmpf, 1);
	_height = (number) tmpf;

	OX_LOG(Logger::LOG_INFO, "Initializing HardCylinder interaction with height %g", _height);

	// r_cut for outer bounding box
	this->_rcut = (number) 1.001 * 2. * sqrt(0.5 * 0.5 + (_height / 2.) * (_height / 2.));

	OX_LOG(Logger::LOG_INFO, "Using r_cut of %g", this->_rcut);
}

void HardCylinderInteraction::init() {
	this->_sqr_rcut = SQR(this->_rcut);
}

void HardCylinderInteraction::allocate_particles(std::vector<BaseParticle *> &particles) {
	for(uint i = 0; i < particles.size(); i++) {
		particles[i] = new BaseParticle();
	}
}

number HardCylinderInteraction::pair_interaction(BaseParticle *p, BaseParticle *q, LR_vector *r, bool update_forces) {
	return pair_interaction_nonbonded(p, q, r, update_forces);
}

number HardCylinderInteraction::pair_interaction_bonded(BaseParticle *p, BaseParticle *q, LR_vector *r, bool update_forces) {
	return (number) 0.f;
}

number HardCylinderInteraction::pair_interaction_nonbonded(BaseParticle *p, BaseParticle *q, LR_vector *r, bool update_forces) {
	LR_vector computed_r(0, 0, 0);
	if(r == NULL) {
		computed_r = this->_box->min_image(p->pos, q->pos);
		r = &computed_r;
	}

	return _hc_pot(p, q, r, update_forces);
}

void HardCylinderInteraction::check_input_sanity(std::vector<BaseParticle *> &particles) {

}
